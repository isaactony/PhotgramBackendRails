# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Users

User.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all
Follow.destroy_all

User.create!(
  name: 'John Doe',
  username: 'johndoe',
  email: 'johndoe@example.com',
  password_digest: '56789',
  profile_pic: 'https://picsum.photos/200',
  background_image: 'https://picsum.photos/1200/800',
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac commodo purus, et commodo eros. In hac habitasse platea dictumst. Nullam venenatis sem ac est fermentum, ut malesuada dui consequat. Sed bibendum velit vel ipsum iaculis, eget egestas nunc vestibulum.'
)

User.create!(
  name: 'Jane Doe',
  username: 'janedoe',
  email: 'janedoe@example.com',
  password_digest: '12346',
  profile_pic: 'https://picsum.photos/200',
  background_image: 'https://picsum.photos/1200/800',
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac commodo purus, et commodo eros. In hac habitasse platea dictumst. Nullam venenatis sem ac est fermentum, ut malesuada dui consequat. Sed bibendum velit vel ipsum iaculis, eget egestas nunc vestibulum.'
)
User.create!(
  name: 'Bob Smith',
  username: 'bobsmith',
  email: 'bobsmith@example.com',
  password_digest: 'abc123',
  profile_pic: 'https://picsum.photos/200',
  background_image: 'https://picsum.photos/1200/800',
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac commodo purus, et commodo eros. In hac habitasse platea dictumst. Nullam venenatis sem ac est fermentum, ut malesuada dui consequat. Sed bibendum velit vel ipsum iaculis, eget egestas nunc vestibulum.'
)


# Posts
Post.create!(
  user_id: 1,
  post_pic: 'https://picsum.photos/800/600',
  caption: 'This is a post from John'
)

Post.create!(
  user_id: 2,
  post_pic: 'https://picsum.photos/800/600',
  caption: 'This is a post from Jane'
)

# Likes
Like.create!(
  post_id: 1,
  user_id: 2
)

Like.create!(
  post_id: 2,
  user_id: 1
)

# Comments
Comment.create!(
  post_id: 1,
  user_id: 2,
  comment: 'Nice post!'
)

Comment.create!(
  post_id: 2,
  user_id: 1,
  comment: 'Great photo!'
)

# Follows
Follow.create!(
  follower_id: 1,
  following_id: 2
)

Follow.create!(
  follower_id: 2,
  following_id: 1
)
