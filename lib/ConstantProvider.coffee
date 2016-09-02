Utility = require './Utility'
AbstractProvider = require './AbstractProvider'

module.exports =

##*
# Provides tooltips for member methods.
##
class MethodProvider extends AbstractProvider
    ###*
     * @inheritdoc
    ###
    hoverEventSelectors: '.constant.other.php'

    ###*
     * @inheritdoc
    ###
    getTooltipForWord: (editor, bufferPosition, name) ->
        return new Promise (resolve, reject) =>
            successHandler = (constants) =>
                if name?[0] != '\\'
                    name = '\\' + name

                if constants and name of constants
                    resolve(Utility.buildTooltipForConstant(constants[name]))
                    return

                reject()

            failureHandler = () =>
                reject()

            return @service.getGlobalConstants().then(successHandler, failureHandler)
