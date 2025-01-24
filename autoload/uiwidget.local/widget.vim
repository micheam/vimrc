vim9script

export interface Widget
	def Render(): void
	def Close(): void
endinterface

defcompile
# vim: set tabstop=4 shiftwidth=4 noexpandtab:
