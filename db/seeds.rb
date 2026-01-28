User.create!(
  name: "管理者",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: :admin,
  active: true
)
