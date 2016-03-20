class Request < ActiveRecord::Base
  belongs_to :user

  enum request_type: {
    book_request: 0,
    bug_report: 1,
    idea: 2,
    thanks: 3
  }

end
