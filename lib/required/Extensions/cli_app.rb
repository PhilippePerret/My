# encoding: UTF-8
=begin

  Module fonctionnement avec le module cli.rb qui permet de définir, pour
  l'application propre, la conversion des diminutifs.

=end

class CLI
  # Raccourcis pour les commandes
  DIM_CMD_TO_REAL_CMD = {
    'prox'        => 'proximites',
    'watch-prox'  => 'watch-proximites'
  }
  DIM_OPT_TO_REAL_OPT = {
    'bm'              => 'benchmark',
    'c'               => 'children',
    'doc'             => 'document',
    'f'               => 'force',
    'h'               => 'help',
    'k'               => 'kill',
    'm'               => 'modifier',
    'vb'              => 'verbose',

    'now'             => 'today'
  }
end#/CLI
