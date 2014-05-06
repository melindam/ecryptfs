#
# ecryptfs needs a file for booting - /root/.ecryptfsrc if its there, remove it
#
file "/root/.ecryptfsrc" do
  action :delete
end
