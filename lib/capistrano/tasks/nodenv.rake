SSHKit.config.command_map = Hash.new do |hash, key|
  if fetch(:nodenv_map_bins).include?(key.to_s)
    prefix = "NODENV_ROOT=#{fetch(:nodenv_path)} NODENV_VERSION=#{fetch(:nodenv_node)} #{fetch(:nodenv_path)}/bin/nodenv exec"
    hash[key] = "#{prefix} #{key}"
  else
    hash[key] = key
  end
end

namespace :deploy do
  before :starting, :hook_nodenv_bins do
    invoke :'nodenv:check'
  end
end

namespace :nodenv do
  task :check do
    on roles(:all) do
      nodenv_node = fetch(:nodenv_node)
      if nodenv_node.nil?
        error "nodenv: nodenv_node is not set"
        exit 1
      end

      if test "[ ! -d #{fetch(:nodenv_node_dir)} ]"
        error "nodenv: #{nodenv_node} is not installed or not found in #{fetch(:nodenv_node_dir)}"
        exit 1
      end
    end
  end
end

namespace :load do
  task :defaults do

    set :nodenv_path, -> {
      nodenv_path = fetch(:nodenv_custom_path)
      nodenv_path ||= if fetch(:nodenv_type, :user) == :system
        "/usr/local/nodenv"
      else
        "~/.nodenv"
      end
    }

    set :nodenv_node_dir, -> { "#{fetch(:nodenv_path)}/versions/#{fetch(:nodenv_node)}" }
    set :nodenv_map_bins, %w{node npm}
  end
end
