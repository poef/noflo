noflo = require "noflo"

class RemoveProperty extends noflo.Component
    constructor: ->
        @properties = []
        @inPorts =
            in: new noflo.Port()
            property: new noflo.ArrayPort()
        @outPorts =
            out: new noflo.Port()

        @inPorts.property.on "data", (data) =>
            @properties.push data

        @inPorts.in.on "begingroup", (group) =>
            @outPorts.out.beginGroup group
        @inPorts.in.on "data", (data) =>
            @outPorts.out.send @removeProperties data
        @inPorts.in.on "endgroup", =>
            @outPorts.out.endGroup()
        @inPorts.in.on "disconnect", =>
            @outPorts.out.disconnect()

    removeProperties: (object) ->
        for property in @properties
            delete object[property]
        return object

exports.getComponent = -> new RemoveProperty
