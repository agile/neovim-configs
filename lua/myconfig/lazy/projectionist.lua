return {
  "tpope/vim-projectionist",
  config = function()
    vim.g.projectionist_heuristics = {
      ["*"] = {
        ["src/main/java/*.java"] = {
          alternate = "src/test/java/{}Test.java",
        },
        ["src/test/java/*Test.java"] = {
          alternate = "src/main/java/{}.java",
        },
        ["src/main/scala/*.scala"] = {
          alternate = "src/test/scala/{}Spec.scala",
        },
        ["src/test/scala/*Spec.scala"] = {
          alternate = "src/main/scala/{}.scala",
        },
        ["development/**/terragrunt.hcl"] = {
          alternate = "production/{}/terragrunt.hcl",
        },
        ["production/**/terragrunt.hcl"] = {
          alternate = "development/{}/terragrunt.hcl",
        },
      },
    }
  end,
}
