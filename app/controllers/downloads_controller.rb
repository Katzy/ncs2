class DownloadsController < ApplicationController
 
 def show
    respond_to do |format|
      format.pdf { send_wrestler_pdf }
    end
  end

  private

  def wrestler
    Wrestler.find(params[:wrestler_id])
  end

  def download
    WrestlerPdf.new(wrestler)
  end

  def send_wrestler_pdf
    send_file download.to_pdf, download_attributes
  end

  def download_attributes
    {
      filename: download.filename,
      type: "application/pdf",
      disposition: "inline"
    }
  end
  # def show
  #   @wrestler = Wrestler.find(params[:wrestler_id])
  #   respond_to do |format|
  #     format.pdf { send_wrestler_pdf }
  #     #  if Rails.env.development?
  #     #   format.html { render_sample_html }
  #     # end
  #   end
  # end
 
  # private
 
  # def wrestler_pdf
  #   wrestler = @wrestler
  #   WrestlerPdf.new(wrestler)
  # end
 
  # def send_wrestler_pdf
  #   send_file wrestler_pdf.to_pdf,
  #     filename: wrestler_pdf.filename,
  #     type: "application/pdf",
  #     disposition: "inline"
  # end
  
  # def render_sample_html
  #   render template: "wrestlers/pdf", layout: "wrestler_pdf", locals: { wrestler: @wrestler }
  # end
end