module.exports =

    config:
        'save':
            title: 'Enable Save'
            type: 'boolean'
            default: true
        'convert-spaces-to-tabs':
            title: 'Enable Convert Spaces to Tabs'
            type: 'boolean'
            default: true

    activate: (state) ->
        require('atom-package-deps').install('toolbar-custom')

    deactivate: ->
        @toolBar?.removeItems()

    serialize: ->

    consumeToolBar: (toolBar) ->
        @toolBar = toolBar 'main-tool-bar'

        @toolBar.addButton
            icon: 'file'
            callback: 'application:new-file'
            tooltip: 'New File'

        @toolBar.addButton
            icon: 'file-directory'
            callback: 'application:open-file'
            tooltip: 'Open...'

        if atom.config.get('toolbar-custom.save')
            @toolBar.addButton
                icon: 'clippy'
                callback: 'core:save'
                tooltip: 'Save'

        @toolBar.addButton
            icon: 'search'
            callback: 'find-and-replace:toggle'
            tooltip: 'Toggle Find and Replace'

        @toolBar.addSpacer()

        @toolBar.addButton
            icon: 'mark-github'
            callback: 'github:toggle-git-tab'
            tooltip: 'Toggle Git Tab'

        @toolBar.addButton
            icon: 'three-bars'
            callback: 'command-palette:toggle'
            tooltip: 'Toggle Command Palette'

        @toolBar.addButton
            icon: 'gear'
            callback: 'settings-view:open'
            tooltip: 'Open Settings View'

        @toolBar.addSpacer()

        if atom.packages.getLoadedPackage('open-in-sourcetree')
            @toolBar.addButton
                icon: 'sourcetree-plain'
                callback: 'open-in-sourcetree:open'
                tooltip: 'Open in SourceTree'
                iconset: 'devicon'

        if atom.config.get('toolbar-custom.convert-spaces-to-tabs')
            @toolBar.addButton
                icon: 'code'
                callback: 'whitespace:convert-spaces-to-tabs'
                tooltip: 'Convert Spaces to Tabs'

        if atom.inDevMode()
            @toolBar.addSpacer()

            @toolBar.addButton
                icon: 'sync'
                callback: 'window:reload'
                tooltip: 'Reload Window'

            @toolBar.addButton
                icon: 'terminal'
                callback: ->
                    require('remote').getCurrentWindow().toggleDevTools()
                tooltip: 'Toggle Developer Tools'
