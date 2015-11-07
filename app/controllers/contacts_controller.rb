class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :share]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
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
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, emails: [], phones: [])
  end
end
