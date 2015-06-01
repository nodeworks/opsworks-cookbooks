#
# Author:: Tugdual Saunier (<tugdual.saunier@sensiolabs.com>)
# Cookbook Name:: blackfire
# Attributes:: default
#
# Copyright 2014-2015, SensioLabs

default['blackfire']['repository'] = 'http://packages.blackfire.io'
default['blackfire']['install_repository'] = true

default['blackfire']['agent']['version'] = nil
default['blackfire']['agent']['collector'] = 'https://blackfire.io'
default['blackfire']['agent']['server_id'] = 'fec49b67-2cc5-4bb7-ad61-64c28ef8ddef'
default['blackfire']['agent']['server_token'] = '8cda601fa36d60f5f3b9937247e46d89bd0f8c131e3852ce2ac86e31c8846330'
default['blackfire']['agent']['log_level'] = 1
default['blackfire']['agent']['log_file'] = 'stderr'
default['blackfire']['agent']['socket'] = 'unix:///var/run/blackfire/agent.sock'
default['blackfire']['agent']['restart_mode'] = :delayed
default['blackfire']['php']['server_id'] = 'fec49b67-2cc5-4bb7-ad61-64c28ef8ddef'
default['blackfire']['php']['server_token'] = '8cda601fa36d60f5f3b9937247e46d89bd0f8c131e3852ce2ac86e31c8846330'
