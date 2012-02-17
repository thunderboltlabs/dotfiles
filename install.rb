#!/usr/bin/env ruby

require "FileUtils"
require "pathname"

$me = File.basename(__FILE__)
$base = Pathname.new(File.dirname(__FILE__))
$home = Pathname.new(ENV["HOME"])

def link_path(file)
  file = ".gitignore" if file == "gitignore"
  $home.join(file).expand_path
end

def target_path(file)
  $base.join(file).expand_path
end

def link_file!(f)
  FileUtils.rm_rf(link_path(f))
  FileUtils.ln_s(target_path(f), link_path(f), verbose: true)
end

Dir.glob("*", File::FNM_DOTMATCH).each do |file|
  next if %w(. .. .git .gitignore Readme.md WARNING.md).include? file
  next if file =~ /.swp/
  next if file =~ /.swo/
  next if file == $me
  link_file!(file)
end

