class TestResultParserWorker < BaseWorker

  def perform(test_results_from_file_id)
    unless test_results_from_file = TestResultsFromFile.find_by_id(test_results_from_file_id)
      log "No record Fetched using test_results_from_file_id - #{test_results_from_file_id}"
      return
    end

    log "test_results_from_file_id - #{test_results_from_file.id} - \n\
      school branch name and id- #{test_results_from_file.school_branch.name}-#{test_results_from_file.school_branch_id}"


    TestResultParser.parse(
        test_results_from_file: test_results_from_file,
        parse_with: Roo::CSV,
        school_branch_id: test_results_from_file.school_branch_id
      )

    log("Test Result Parsing Complete")
  rescue Exception => e
    log e.message
    log e.backtrace
  end

end