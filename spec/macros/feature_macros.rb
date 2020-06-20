module FeatureMacros
  def visit_user(user)
    sign_in(user)
    visit root_path
  end

  def visit_quest
    visit root_path
  end
end
