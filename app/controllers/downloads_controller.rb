class DownloadsController < ApplicationController
 
  def show
    respond_to do |format|
      format.js { render "alert('Hello World');"}
      format.pdf { send_wrestler_pdf }
    end
  end
 
  private
 
  def wrestler_pdf
    wrestler = Wrestler.find(params[:wrestler_id])
    WrestlerPdf.new(wrestler)
  end
 
  def send_wrestler_pdf
    send_file wrestler_pdf.to_pdf,
      filename: wrestler_pdf.filename,
      type: "application/pdf",
      disposition: "attachment"
  end
end