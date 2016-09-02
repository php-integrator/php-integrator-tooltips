Utility = require './Utility'
AbstractProvider = require './AbstractProvider'

module.exports =

##*
# Provides tooltips for global functions.
##
class FunctionProvider extends AbstractProvider
    ###*
     * @inheritdoc
    ###
    hoverEventSelectors: '.function-call:not(.object):not(.static), .support.function:not(.magic)'

    ###*
     * @inheritdoc
    ###
    getTooltipForWord: (editor, bufferPosition, name) ->
        return new Promise (resolve, reject) =>
            successHandler = (functions) =>
                if name?[0] != '\\'
                    name = '\\' + name
                    
                if functions and name of functions
                    resolve(Utility.buildTooltipForFunction(functions[name]))
                    return

                reject()

            failureHandler = () =>
                reject()

            return @service.getGlobalFunctions().then(successHandler, failureHandler)
