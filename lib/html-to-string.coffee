module.exports =
  activate: (state) ->
    atom.workspaceView.command 'htmlToString:convert', => @convert()
    atom.workspaceView.command 'htmlToString:deconvert', => @deconvert()
  
  convert: ->
    editor = atom.workspace.getActiveEditor()
    return if !editor
    
    selection = editor.getSelection()
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

  deconvert: ->
    editor = atom.workspace.getActiveEditor()
    return if !editor
    
    selection = editor.getSelection()
    selectedText = selection.getText()
    convertText = selectedText.split('\n').map((line) =>
      trimedText = line.trim()
        .replace(/\s?\+\s?/, '')
        .replace(/^'/, '')
        .replace(/'$/, '')
      spaceCount = line.indexOf(trimedText)
      space = ''
      for i in [0...spaceCount-1]
        space += ' '
      return "#{space}#{trimedText}"
    ).join('\n')
    
    selection.insertText(convertText,
      select: true
    )
