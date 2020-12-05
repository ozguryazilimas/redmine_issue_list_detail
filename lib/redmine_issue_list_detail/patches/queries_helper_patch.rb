require_dependency 'queries_helper'

module RedmineIssueListDetail
  module Patches
    module QueriesHelperPatch

      def column_value(column, issue, value)
        Rails.logger.info "\x1b[1;33m issue #{issue.id} column.name #{column.name} \x1b[0m"

        if column.name == :relations
          content_tag('span',
            value.to_s(issue) do |other|
              text = "##{other.id} (#{other.status})"
              title = other.subject.truncate(60)
              link_to(text, issue_url(other, :only_path => true), :class => other.css_classes, :title => title)
            end.html_safe,
            :class => value.css_classes_for(issue))
        else
          super
        end
      end

    end
  end
end

QueriesHelper.prepend(RedmineIssueListDetail::Patches::QueriesHelperPatch)


