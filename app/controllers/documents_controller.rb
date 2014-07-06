class DocumentsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_document, only: [:show, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Paginate.get_records(
        relation_object: current_school_branch.documents,
        page: params[:page],
        per_page: params[:per_page]
      )
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.school_branch = current_school_branch
    @document.creator = current_teacher || current_entity

    respond_to do |format|
      if @document.save
        DocumentParserWorker.perform_async @document.id

        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = current_school_branch.documents.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :document_type)
    end
end
