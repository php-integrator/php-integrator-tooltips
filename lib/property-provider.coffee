AbstractProvider = require './abstract-provider'

module.exports =

##*
# Provides tooltips for member properties.
##
class PropertyProvider extends AbstractProvider
    ###*
     * @inheritdoc
    ###
    hoverEventSelectors: '.property'

    ###*
     * @inheritdoc
    ###
    getTooltipForWord: (editor, bufferPosition, name) ->
        value = @service.getClassMember(editor, bufferPosition, name)

        return unless value

        accessModifier = ''
        returnType = if value.args.return then value.args.return else 'mixed'

        if value.isPublic
            accessModifier = 'public'

        else if value.isProtected
            accessModifier = 'protected'

        else
            accessModifier = 'private'

        # Create a useful description to show in the tooltip.
        description = ''

        description += "<p><div>"
        description += accessModifier + ' ' + returnType + '<strong>' + ' $' + name + '</strong>'
        description += '</div></p>'

        # Show the summary (short description).
        description += '<div>'
        description +=     (if value.args.descriptions.short then value.args.descriptions.short else '(No documentation available)')
        description += '</div>'

        # Show the (long) description.
        if value.args.descriptions.long?.length > 0
            description += '<div class="section">'
            description +=     "<h4>Description</h4>"
            description +=     "<div>" + value.args.descriptions.long + "</div>"
            description += "</div>"

        if value.args.return
            description += '<div class="section">'
            description +=     "<h4>Type</h4>"
            description +=     "<div>" + value.args.return + "</div>"
            description += "</div>"

        return description
