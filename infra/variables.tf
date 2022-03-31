variable "aws_access_key" {
  sensitive = true
}

variable "aws_secret_key" {
  sensitive = true
}

# in best practise, this should not be passed to lambda
# via env variable and this should be kept in something
# like KMS or vault.
# But anyway, let's save some money ATM =)
variable "bot_api_token" {
  description = "The API Token from Telegram's @BotFather"
  sensitive   = true
}
