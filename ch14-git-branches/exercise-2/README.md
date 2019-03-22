# Exercise-2
In this exercise, you'll practice resolving a merge conflict.

> This is a line you will change!

For this exercise, complete the following steps:

1. You should have cloned _this_ module repository. Make sure you are on the `master` branch, and that all changes are committed.

2. Create and `checkout` a new branch called `danger`

3. On the `danger` branch, use Atom or another text editor to change the above block-quoted line so it contains the word "Warning!" It should still be in a block-quote.

4. `commit` your change with an appropriate commit message.

5. `checkout` the `master` branch again.

6. Now change the above block-quoted line so it contains your favorite movie quote. It should still be in a block-quote.

7. `commit` your change with an appropriate commit message.

8. Use `git merge danger` to merge the `danger` branch ___into___ the `master` branch. **This should cause a merge conflict**

9. **Don't panic**

10. Use Atom or another text editor to **resolve the merge conflict** You will need to make the file look exactly as you want the code to appear, includig removing the `<<<<<<`, `======` and `>>>>>>`.

11. Be sure to `add` and `commit` that you've resolved the conflict.

12. Use `git status` to confirm that everything is now merged.
