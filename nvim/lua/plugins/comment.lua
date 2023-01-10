local setup, comment = pcall(require, "Comment")
if not setup then
    print("Could not import Comment in comment.lua!")
    return
end

comment.setup()
