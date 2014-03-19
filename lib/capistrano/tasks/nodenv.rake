namespace :nodenv do
  task :check do
    on roles(fetch(:nodenv_roles)) do
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

  task :map_bins do
    nodenv_prefix = "NODENV_ROOT=#{fetch(:nodenv_path)} NODENV_VERSION=#{fetch(:nodenv_ruby)} #{fetch(:nodenv_path)}/bin/nodenv exec"

    fetch(:nodenv_map_bins).each do |command|
      SSHKit.config.command_map.prefix[command.to_sym].unshift(nodenv_prefix)
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'nodenv:map_bins'
  after stage, 'nodenv:check'
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

    set :nodenv_roles, fetch(:nodenv_roles, :all)

    set :nodenv_node_dir, -> { "#{fetch(:nodenv_path)}/versions/#{fetch(:nodenv_node)}" }
    set :nodenv_map_bins, %w{node npm}
  end
end
