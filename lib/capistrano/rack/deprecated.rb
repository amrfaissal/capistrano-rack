require 'capistrano/rack/colorize'

module Deprecated
  def deprecated_alias(name, replacement)
    define_method(name) do |*args, &block|
      warn "[DEPRECATION]".bold.red +  " `#{name}` is deprecated. Please use `#{replacement}` instead.".bold.blue
      send replacement, *args, &block
    end
  end

  def deprecated(name, replacement=nil)
    # Replace old method with a wrapped version
    old_name = :"#{name}_without_deprecation"
    alias_method old_name, name
    define_method(name) do |*args, &block|
      if replacement
        warn "[DEPRECATION]".bold.red +  " `#{name}` is deprecated. Please use `#{replacement}` instead.".bold.blue
      else
        warn "[DEPRECATION]".bold.red +  " `#{name}` is deprecated.".bold.blue
      end
      send old_name, *args, &block
    end
  end
end
