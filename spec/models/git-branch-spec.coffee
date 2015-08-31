git = require '../../lib/git'
{repo, pathToRepoFile} = require '../fixtures'
{gitBranches, newBranch} = require '../../lib/models/git-branch'

describe "GitBranch", ->
  beforeEach ->
      spyOn(atom.workspace, 'addModalPanel').andCallThrough()

  describe ".gitBranches", ->
    beforeEach ->
      spyOn(git, 'cmd').andReturn Promise.resolve 'branch1\nbranch2'
      waitsForPromise -> gitBranches(repo)

    it "displays a list of the repo's branches", ->
      expect(git.cmd).toHaveBeenCalledWith ['branch'], cwd: repo.getWorkingDirectory()
      expect(atom.workspace.addModalPanel).toHaveBeenCalled()

  describe ".newBranch", ->
    beforeEach ->
      spyOn(git, 'cmd').andReturn -> Promise.reject 'new branch created'
      newBranch(repo)

    it "displays a text input", ->
      expect(atom.workspace.addModalPanel).toHaveBeenCalled()

    # it "creates a branch with the name entered in the input view", ->
    #   branchName = 'neat/-branch'
    #   @view.branchEditor.setText branchName
    #   @view.createBranch()
    #   expect(git.cmd).toHaveBeenCalledWith ['checkout', '-b', branchName]
