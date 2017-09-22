- Why are we using matrices for this problem?

You don't have to. There are many other ways to calculate the statistics in question. But using an age-period matrix simplifies the for-loop because all you need to do in order to calculate period specific statistics is to loop over the columns of the matrix.

- I don't understand lists and indexing.

Reading http://r4ds.had.co.nz/vectors.html may help you understand bracket indexing and lists.

- We are creating a vector, which has the length of D columns... what is mode = 'list'?

Actually we use the function `vector()` to create a "list" with D entries.

- What does `sapply()` do?

`sapply` applies a function to each element of a list and simplifies the results to a vector or a matrix.

- What about those double brackets?

`list[i]` returns the ith element of a list as a list. `list[[i]]` returns the content of the ith element of a list as whatever the content is.

For example, if the ith element of a list is a vector with numbers 0 to 10 then list[i] returns a list with a single entry and the entry is a vector of numbers 0 to 10. list[[i]] would just return a vector of numbers 0 to 10.