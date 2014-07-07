class DocumentParserWorker < BaseWorker

  def perform(document_id)
    unless document = Document.find_by_id(document_id)
      log "No document Fetched using document_id - #{document_id}"
      return
    end

    log "document_id - #{document.id} - \n\
      Parsing #{document.document_type} document \n\
      school branch name and id- #{document.school_branch.name}-#{document.school_branch_id}"

    parser_type = document.document_type.gsub(/\s/, '_').camelize
    parser = Kernel.const_get("Parser::#{parser_type}Parser")
    parser.new(document).parse

    log("Parsing Complete")
  rescue Exception => e
    log e.message
    log e.backtrace
  end

end