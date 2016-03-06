Utility = require './Utility'
AbstractProvider = require './AbstractProvider'

module.exports =

##*
# Provides tooltips on function and method definitions.
##
class FunctionDefinitionProvider extends AbstractProvider
    ###*
     * @inheritdoc
    ###
    hoverEventSelectors: '.entity.name.function, .support.function.magic'

    ###*
     * @inheritdoc
    ###
    getTooltipForWord: (editor, bufferPosition, name) ->
        try
            currentClassName = @service.determineCurrentClassName(editor, bufferPosition)

        catch error
            return null

        value = null

        try
            if currentClassName?
                value = @service.getClassMethod(currentClassName, name)

            else
                globalFunctions = @service.getGlobalFunctions()

                if name of globalFunctions
                    value = globalFunctions[name]

        catch error
            return null

        return unless value

        return Utility.buildTooltipForFunction(value)
