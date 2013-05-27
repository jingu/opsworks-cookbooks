#
# Cookbook Name:: deploy
# Recipe:: eccube
#
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end
  script "chmod_applicaton" do
    Chef::Log.info("logs,tmp permission change ")
    interpreter "bash"
    cwd deploy[:deploy_to]
    user "root"
    code <<-EOH
    chmod -R 777 current/logs current/tmp/cache_lite current/tmp/misc current/tmp/session current/tmp/smarty_cache current/tmp/smarty_templates_c current/tmp/upload
    EOH
  end
  script "rename htaccess" do
    Chef::Log.info("rename .htaccess ")
    interpreter "bash"
    cwd deploy[:deploy_to]
    user "root"
    code <<-EOH
    cp current/htdocs/.htaccess.live current/htdocs/.htaccess
    EOH
  end
end
