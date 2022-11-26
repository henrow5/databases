## Exercise One

Use a `SELECT` query with a `JOIN` to retrieve all the posts associated with the tag
`'travel'`.

You should get the following result set:

```
 id |          title          
----+-------------------------
  4 | My weekend in Edinburgh
  6 | A foodie week in Spain
```

Solution:

```sql
SELECT posts.id, posts.title
  FROM posts 
    JOIN posts_tags ON posts_tags.post_id = posts.id
    JOIN tags ON posts_tags.tag_id = tags.id
    WHERE tags.id = 2;
```
<!-- OMITTED -->

## Challenge

Use SQL to insert a new tag `'sql'` and associate the post titled `'SQL basics'` with this tag.

Then use a `SELECT` query with a `JOIN` to retrieve all posts associated with the tag
`'sql'` and verify the above worked.

Solution:

```sql
INSERT INTO tags (name) VALUES ('sql');

INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 5);
```

```sql
SELECT posts.id, posts.title
  FROM posts 
    JOIN posts_tags ON posts_tags.post_id = posts.id
    JOIN tags ON posts_tags.tag_id = tags.id
    WHERE tags.id = 5;
```

```
 id |          title          
----+-------------------------
  7 | SQL basics
```