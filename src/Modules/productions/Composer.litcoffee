#  `Modules.Composer`  #

##  Usage  ##

>   ```jsx
>       <Composer
>           maxChars=React.PropTypes.number.isRequired
>           myID=React.PropTypes.number.isRequired
>           visible=React.PropTypes.boolean
>           defaultPrivacy=React.PropTypes.string
>           text=React.PropTypes.string
>           inReplyTo=React.PropTypes.number
>       />
>   ```
>   Creates a `Composer` component, which allows a user to compose a post. The accepted properties are:
>   -   **`maxChars` [REQUIRED `number`] :**
>       The maximum number of characters allowed in a post. closed.
>   -   **`myID` [REQUIRED `number`] :**
>       The account object for the currently signed-in user.
>   -   **`visible` [OPTIONAL `boolean`] :**
>       Whether or not to show the composer
>   -   **`defaultPrivacy` [OPTIONAL `string`] :**
>       Should be one of {`"public"`, `"private"`, `"unlisted"`}, and effectively defaults to `"unlisted"` if not provided.
>   -   **`text` [OPTIONAL `string`] :**
>       The initial text for the composer.
>   -   **`inReplyTo` [OPTIONAL `number`] :**
>       The post ID which this post is replying to.

##  The Component  ##

The `Composer` class creates our post composition module, which is a surprisingly complex task.

    Modules.Composer = React.createClass

        mixins: [ReactPureRenderMixin]

        propTypes:
            maxChars: React.PropTypes.number.isRequired
            myID: React.PropTypes.number.isRequired
            defaultPrivacy: React.PropTypes.string
            visible: React.PropTypes.bool
            text: React.PropTypes.string
            inReplyTo: React.PropTypes.number

        getDefaultProps: ->
            text: ""
            inReplyTo: undefined

###  Our state:

Here you can see our initial state variables—we have quite a lot of them, as this component manages the extensive compose form.
You will note that `text` is initialized to `\n`—in order to function properly, a line break must always be the last thing it produces.

        getInitialState: ->
            account: null
            replyStatus: null
            text: @props.text + "\n"
            inReplyTo: if isFinite @props.inReplyTo then Number @props.inReplyTo else undefined
            message: ""
            charsLeft: @props.maxChars
            makePublic: @props.defaultPrivacy isnt "private"
            makeListed: @props.defaultPrivacy is "public"
            makeNSFW: false
            forceNSFW: true
            useMessage: false
            shouldClose: false

###  Pulling from the context:

We will also need `intl` from the React context in order to access the composer placeholder text.

        contextTypes:
            intl: React.PropTypes.object.isRequired

###  Handling the event callback:

When we receive a response from Laboratory, we have to handle it with respect to our state.

        handleResponse: (event) ->
            response = event.detail
            switch
                when response instanceof Laboratory.Profile then @setState {account: response}
                when response instanceof Laboratory.Post and response.id is @props.inReplyTo then @setState {replyStatus: response}
            return

###  Loading:

When our compose module first loads, we should request the account data for the currently signed-in user.
We'll also request the status the post is replying to, if applicable.

        componentWillMount: ->
            Laboratory.listen "LaboratoryProfileReceived", @handleResponse
            Laboratory.dispatch "LaboratoryProfileRequested", {id: @props.myID}
            if isFinite @props.inReplyTo
                Laboratory.listen "LaboratoryPostReceived", @handleResponse
                Laboratory.dispatch "LaboratoryPostRequested", {id: @props.inReplyTo}

###  Unloading:

When our compose module unloads, we should signal that we no longer need its data.

        componentWillUnmount: ->
            Laboratory.forget "LaboratoryProfileReceived", @handleResponse
            Laboratory.forget "LaboratoryPostReceived", @handleResponse

###  Our inputs:

We store our inputs in a instance variable, and you'll see in `render()` that we're using the `ref` attribute to get their values.

        input:
            textbox: null
            message: null
            makePublic: null
            makeListed: null
            makeNSFW: null
            useMessage: null
            post: null

###  Updating:

The `shouldClose` state variable is used to register the fact that a post has been sent, and the composer module should now close.
However, we don't want this variable to *keep* signalling this fact if we then open the composer a second time.
If our `visible` property switches from `false` to `true` then we reset `shouldClose` before proceeding.

        componentWillReceiveProps: (nextProps) ->

            @setState {shouldClose: false} if not @props.visible and nextProps.visible

If our props are about to change so we are replying to a different status, we need to request it.

            if (isFinite nextProps.inReplyTo) and nextProps.inReplyTo isnt @props.inReplyTo
                Laboratory.listen "LaboratoryPostReceived", @handleResponse
                Laboratory.dispatch "LaboratoryPostRequested", {id: nextProps.inReplyTo}

If our props update, we should update the store to reflect the new data.

            @setState {text: nextProps.text + "\n"} if nextProps.text isnt @props.text
            @setState {inReplyTo: Number nextProps.inReplyTo} if (isFinite nextProps.inReplyTo) and nextProps.inReplyTo isnt @props.inReplyTo

###  Finding out how many characters are left:

This code quickly replaces all surrogate pairs with a single underscore to achieve an accurate character count.

        getCharsLeft: -> @charsLeft = @props.maxChars - ((@input.textbox.value + @input.message.value).replace /[\uD800-\uDBFF][\uDC00-\uDFFF]/g, "_").length + 1

###  Formatting our text:

This code is used to generate the HTML content of our textbox.
We do this by creating text nodes inside a `<div>` in order to keep our text properly encapsulated and safe.
We then return the `innerHTML` of the result.

We use `<br>`s to represent line-breaks because these have the best browser support.
Again, in order for everything to function smoothly we need to ensure that the last node in this result is a `<br>` element.

        format: (text) ->
            result = document.createElement "div"
            lines = text.split "\n"
            for i in [0..lines.length-1]
                result.appendChild document.createTextNode lines[i] if lines[i]
                result.appendChild document.createElement "br" if i isnt lines.length - 1 or lines[i]
            return result.innerHTML

###  Event handling:

This handles the events from all of our inputs *except* our textbox, essentially just setting the corresponding state value.
We also do checks regarding public/private and listed/unlisted to make sure you don't set a forbidden combination.

        handleEvent: (event) ->
            switch event.type
                when "change"
                    switch event.target
                        when @input.message then @setState
                            message: @input.message.value
                            charsLeft: do @getCharsLeft
                        when @input.makePublic then @setState
                            makePublic: @input.makePublic.checked
                            makeListed: @input.makeListed.checked and @input.makePublic.checked
                            forceListed: not @input.makePublic.checked
                        when @input.makeListed then @setState
                            makePublic: @input.makePublic.checked or @input.makeListed.checked
                            makeListed: @input.makeListed.checked
                        when @input.makeNSFW then @setState {makeNSFW: event.target.checked}
                        when @input.useMessage then @setState {useMessage: event.target.checked}

When a user clicks the "Post" button, we fire off a `Composer.Post` event with our data, wipe (almost) everything, and tell the composer to close.
Public/private and listed/unlisted settings are maintained for the next post.

                when "click"
                    if event.target is @input.post and do @getCharsLeft >= 0
                        Laboratory.dispatch "LaboratoryPostComposed",
                            text: @state.text
                            message: if @state.useMessage then @state.message else null
                            makePublic: @state.makePublic
                            makeListed: @state.makeListed
                            makeNSFW: @state.makeNSFW
                            inReplyTo: @state.inReplyTo
                        @setState
                            replyStatus: null
                            text: "\n"
                            message: ""
                            inReplyTo: undefined
                            charsLeft: @props.maxChars
                            useMessage: false
                            makeNSFW: false
                            forceNSFW: true
                            shouldClose: true

###  Rendering:

Our `render()` function is huge, but most of it is just buttons and their corresponding icons and labels.
Some things to note:

1.  With our inputs aside from our text box, we use `getRef` and not `ref` because it gives us the underlying `<input>`/`<button>` element.

2.  The `"aria-label"` attribute is used to hold our placeholder text.
    This isn't *always* okay, but since our placeholder also describes the textbox, in our case it is.

3.  The `onChange` attribute on our textbox doesn't link to an event listener since in this instance `onChange` doesn't actually produce an event.
    It's just a callback that gets passed the value of the textbox whenever it updates.

4.  If our `visible` property is false then we don't render anything.
    The advantage to this approach over simply not mounting the component is that lit lets us keep our state persistent—in case someone wants to go back and look at a user's account before finishing their thought, for example.

With those things in mind, here's the function:

        render: ->
            return null unless @props.visible and (not @state.inReplyTo or @state.replyStatus?.id is @state.inReplyTo)
            彁 Modules.Module, {attributes: {id: "labcoat-composer"}, close: @state.shouldClose},
                彁 "header", null,
                    if @state.account then 彁 Shared.IDCard, {account: @state.account} else null
                彁 Shared.Textbox,
                    id: "labcoat-composertextbox"
                    "aria-label": @context.intl.messages["composer.placeholder"]
                    onChange: ((text) => @setState {text, charsLeft: do @getCharsLeft})
                    value: @format @state.text
                    ref: ((ref) => @input.textbox = ref)
                彁 "footer", null,
                    彁 "span", {id: "labcoat-count"}, if isNaN @state.charsLeft then "" else @state.charsLeft
                    彁 Shared.Button,
                        onClick: @handleEvent
                        getRef: ((ref) => @input.post = ref)
                        disabled: @state.charsLeft < 0
                        label: 彁 ReactIntl.FormattedMessage,
                            id: "composer.post"
                            defaultMessage: "Post"
                        icon: "icon.post"
                彁 "aside", {id: "labcoat-composeroptions"},
                    彁 "div", {id: "labcoat-postoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makePublic = ref
                            checked: @state.makePublic
                            onChange: @handleEvent
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.private"
                                defaultMessage: "Private"
                            inactiveIcon: "icon.private"
                            activeIcon: "icon.public"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.public"
                                defaultMessage: "Public"
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makeListed = ref
                            checked: @state.makeListed
                            onChange: @handleEvent
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.unlisted"
                                defaultMessage: "Unlisted"
                            inactiveIcon: "icon.unlisted"
                            activeIcon: "icon.listed"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.listed"
                                defaultMessage: "Listed"
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.makeNSFW = ref
                            checked: @state.makeNSFW
                            onChange: @handleEvent
                            disabled: @state.forceNSFW
                            inactiveText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.sfw"
                                defaultMessage: "Safe"
                            inactiveIcon: "icon.sfw"
                            activeIcon: "icon.nsfw"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.nsfw"
                                defaultMessage: "Sensitive"
                    彁 "div", {id: "labcoat-hideoptions"},
                        彁 Shared.Toggle,
                            getRef: (ref) => @input.useMessage = ref
                            checked: @state.useMessage
                            onChange: @handleEvent
                            inactiveText: ""
                            inactiveIcon: "icon.nomessage"
                            activeIcon: "icon.message"
                            activeText: 彁 ReactIntl.FormattedMessage,
                                id: "composer.message"
                                defaultMessage: "Hide behind message"
                        彁 "input",
                            type: "text"
                            placeholder: @context.intl.messages["composer.nomessage"]
                            value: @state.message
                            ref: (ref) => @input.message = ref
                            onChange: @handleEvent
