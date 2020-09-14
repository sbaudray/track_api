# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Track.Repo.insert!(%Track.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, user} =
  Track.Accounts.create_user(%{
    username: "JC",
    email: "jean.charles@mail.com",
    password: "carlito"
  })

Track.Repo.insert!(%Track.Issues.Issue{
  title: "Cannot login",
  body: "I cannot login ffs",
  status: "open",
  author: user
})

Track.Repo.insert!(%Track.Issues.Issue{
  title: "GraphQL clients are baaad",
  body: "Write one fucker",
  status: "open",
  author: user
})

Track.Repo.insert!(%Track.Issues.Issue{
  title: "I can request issues",
  body: "I wanna fetch issues from phoenix api",
  status: "closed",
  author: user
})
