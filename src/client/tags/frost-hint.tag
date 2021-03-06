<frost-hint>
	<div>
		<i class='fa fa-info-circle'></i>
		<p onclick={ change } ref='text'></p>
	</div>

	<style>
		:scope {
			> div {
				display: flex;
				align-items: center;

				> * {
					margin: 0;
				}
				> i {
					margin-right: 0.75rem;
				}
				> p {
					font-size: 1.2rem;
				}
			}
		}
	</style>

	<script>
		this.on('mount', () => {
			this.change = (html) => {
				this.refs.text.innerHTML = html;
			};

			this.change('<a href=\'/userlist\'>ユーザーリスト</a>からユーザーを探してフォローしてみましょう');
		});
	</script>
</frost-hint>
