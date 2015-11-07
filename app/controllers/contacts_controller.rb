class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :share]

  def index
    @contacts = params[:q].present? ? Contact.search(params[:q]) : Contact.all
    respond_to do |format|
      format.html
      format.csv { send_data ContactCsvService.export_to_csv }
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to @contact, notice: t('.notice', resource: Contact.model_name.human)
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: t('.notice', resource: Contact.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: t('.notice', resource: Contact.model_name.human)
  end

  def share
    ContactSharingMailer.share_contact(@contact.id, params.require(:email)).deliver_later
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def import
    ContactCsvService.import_from_csv(params.require(:file).tempfile)
    redirect_to :back, notice: t('.notice', resource: Contact.model_name.human(count: 2))
  rescue ActionController::RedirectBackError
    redirect_to root_path, notice: t('.notice', resource: Contact.model_name.human(count: 2))
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, emails: [], phones: [])
  end
end
