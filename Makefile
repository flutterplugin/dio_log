all: format check pub
format:
	@echo '格式化dart代码---执行｜dart format .｜命令'
	@fvm dart format .
check:
	@echo '检查代码---执行｜dart analyze .｜命令'
	@fvm dart analyze .
pub:
	@echo '发布插件到pub---执行｜packages pub publish --server=https://pub.dev｜命令'
	@fvm flutter packages pub publish --server=https://pub.dev

