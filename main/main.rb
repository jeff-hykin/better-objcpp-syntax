# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")
require_relative './tokens.rb'

# 
# 
# create grammar!
# 
# 
grammar = Grammar.fromTmLanguage(File.join(__dir__, "modified.tmLanguage.json"))

# 
#
# Setup Grammar
#
# 
    # Currently there are "anonymous" patterns that are inside the legacy original.tmLanguage.json
    # they need to be made non-anonymous in order for us to be able to override the :$initial_context
    # grammar[:$initial_context] = [
    #     # (add more stuff here) (variables, strings, numbers)
    # ]

# 
# Helpers
# 
    # @space
    # @spaces
    # @digit
    # @digits
    # @standard_character
    # @word
    # @word_boundary
    # @white_space_start_boundary
    # @white_space_end_boundary
    # @start_of_document
    # @end_of_document
    # @start_of_line
    # @end_of_line
    part_of_a_variable = /[a-zA-Z_][a-zA-Z_0-9]*/
    # this is really useful for keywords. eg: variableBounds[/new/] wont match "newThing" or "thingnew"
    variableBounds = ->(regex_pattern) do
        lookBehindToAvoid(@standard_character).then(regex_pattern).lookAheadToAvoid(@standard_character)
    end
    variable = variableBounds[part_of_a_variable]
    
# 
# basic patterns
# 
    # none yet

# 
# imports
# 
    # none yet

#
# Save
#
name = "objc"
grammar.save_to(
    syntax_name: name,
    syntax_dir: "./autogenerated",
    tag_dir: "./autogenerated",
)