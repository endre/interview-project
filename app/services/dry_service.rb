class DryService
  # read more at https://github.com/dry-rb/dry-initializer
  extend Dry::Initializer

  attr_accessor :error_obj

  class << self
    # Instantiates and calls the service at once
    def call(*args, &block)
      new(*args).call(&block)
    end

    # Accepts both symbolized and stringified attributes
    def new(*args)
      args << args.pop.symbolize_keys if args.last.is_a?(Hash)
      super(*args)
    end
  end

  def success
    self
  end

  def error(e)
    @error_obj = e
    pp e.message
    pp e.backtrace.last(30)
    self
  end

  def success?
    !error_obj
  end

  def error?
    error_obj.present?
  end
end
