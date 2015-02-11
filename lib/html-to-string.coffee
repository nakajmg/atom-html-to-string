module.exports =
  activate: (state) ->
    atom.workspaceView.command 'htmlToString:convert', => @convert()
  
  convert: ->
    editor = atom.workspace.getActiveTextEditor()
    return if !editor
    selectedText = editor.getSelectedText()
    selection = atom.workspace.getActiveEditor().getSelection()
    selectedText = selection.getText()
    convertText = selectedText.split('\n').map((line) =>
      trimedText = line.trimLeft()
      spaceCount = line.indexOf(trimedText)
      space = ''
      for i in [0...spaceCount]
        space += ' '
      return "#{space}'#{line.trimLeft()}'"
    ).join(' +\n')
    
    selection.insertText(convertText,
      select: true
    )
