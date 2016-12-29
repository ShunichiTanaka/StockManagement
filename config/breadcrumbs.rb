crumb :admin_root do
	link 'TOP', root_path
end

crumb :stock_companies do
	link t('admin.stock_companies.index'), admin_stock_companies_path
	parent :admin_root
end

crumb :new_stock_company do |stock_company|
	link t('admin.stock_companies.new'), new_admin_stock_company_path(stock_company)
	parent :stock_companies
end

crumb :edit_stock_company do |stock_company|
	link t('admin.stock_companies.edit'), edit_admin_stock_company_path(stock_company)
	parent :stock_companies
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
