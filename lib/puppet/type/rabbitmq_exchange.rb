Puppet::Type.newtype(:rabbitmq_exchange) do
  desc 'Native type for managing rabbitmq exchanges'

  ensurable do
    defaultto(:present)
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar => true) do
    desc 'Name of exchange'
    newvalues(/^\S*@\S+$/)
  end

  newparam(:type) do
    desc 'Exchange type to be set *on creation*'
  end

  validate do
    if self[:ensure] == :present and self[:type].nil?
      raise ArgumentError, "must set type when creating exchange for #{self[:name]} whose type is #{self[:type]}"
    end
  end

end
