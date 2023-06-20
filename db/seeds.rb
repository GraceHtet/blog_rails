# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#user
tom = User.create(
    name: "Tom",
    bio: 'Tom is a preschool teacher, blogger, speaker, artist and the author of Teacher Tom First Book',
    photo: 'https://i.pravatar.cc/300?u=Tom'
)

lily = User.create(
    name: "Lily",
    bio: 'Lily was one of the 20 New Zealand women selected to work as teachers for Boer children living in the concentration camps in South Africa',
    photo: 'https://i.pravatar.cc/300?u=lily'
)

#post
tom_post1 = Post.create(
    title: "From The Garden",
    text: 'A parent pointed out that her son was eating raw kale that he had picked from the playground garden. "He wont touch it at home, but here, he devours it!"',
    author_id: tom.id
)

tom_post2 = Post.create(
    title: "Understanding What Children Are Crying About",
    text: 'Young parents with a crying infant know that behavior is communication, although it may take weeks or months to figure out exactly what it is their babies are communicating. Does this cry mean I am hungry? Does that one mean I am in pain? Frightened? Tired? ',
    author_id: tom.id
)

tom_post3 = Post.create(
    title: "Understanding What Children Are Crying About 2",
    text: 'Coming to understand our new babies generally involves a lot of trial and error as we try one approach after another. If they reject the breast then we check their diaper. If they do not respond to singing we try rocking, bouncing or cooing. In other words, we try everything we can think of from burping to taking them for a drive until we hit on the proper response.',
    author_id: tom.id
)

tom_post4 = Post.create(
    title: "Understanding What Children Are Crying About 3",
    text: 'The one thing every new parent learns is that the proper response to their baby cried request or query or demand or complaint, is to do something to change their environment or their situation within the environment. It is not our babies that need to change -- they are the one perfect thing in an imperfect world.',
    author_id: tom.id
)

tom_post5 = Post.create(
    title: "Understanding What Children Are Crying About 4",
    text: 'Their crying is feedback on their experience in that imperfect world and their place in it. And in this business of being an adult caretaker, the customer is always right, so we do what we need to do to make the world, at least for a time, a bit more hospitable. Then we do it again and again until one day we decide, usually gradually, but sometimes abruptly like on the first day of school, that it is not the world, but the child that must change.',
    author_id: tom.id
)

lily_post1 = Post.create(
    title: "Not what I expected",
    text: 'I am in my second week of my first practicum and I have been teaching for a few days now. The first week I spend observing my mentor teacher and looking back on itnow, I realize that I could have anticipated the situatuin I am in presently.',
    author_id: lily.id
)

lily_post2 = Post.create(
    title: "To teach or not to teach",
    text: 'The end is finally in sight. I am proud of myself for sticking with it because in all honesty, there were some moments when I was ready to walk away from this whole process.',
    author_id: lily.id
)

lily_post3 = Post.create(
    title: "To teach or not to teach 2",
    text: 'I decided, however, to stick with the practicum and just finish it. I had hoped a conversation with my mum would bolster my confidence and help me reframe th experience so that I could see it from a more positive perspective, but the conversation really didn not happen like that.',
    author_id: lily.id
)

Comment.create([
    {author_id: lily.id, post_id: tom_post1.id, text: "what a funny"},
    {author_id: lily.id, post_id: tom_post2.id, text: "I agree"},
    {author_id: lily.id, post_id: tom_post2.id, text: "I had that kind of situation, too"},
    {author_id: lily.id, post_id: tom_post2.id, text: "I had no idea what my nephew wants or do"},
    {author_id: lily.id, post_id: tom_post2.id, text: "But later I knew that he was hungry"},
    {author_id: tom.id, post_id: tom_post2.id, text: "Oh, that's great"},
    {author_id: tom.id, post_id: tom_post2.id, text: "I'm happy that you handle to solve that."},
])

Like.create([
    {author_id: tom.id, post_id: tom_post1.id},
    {author_id: tom.id, post_id: tom_post2.id},
    {author_id: tom.id, post_id: lily_post3.id},
    {author_id: tom.id, post_id: lily_post1.id},
    {author_id: lily.id, post_id: lily_post3.id},
    {author_id: lily.id, post_id: lily_post1.id},
])
