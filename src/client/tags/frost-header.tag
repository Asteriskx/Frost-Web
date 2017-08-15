<frost-header role='banner'>
	<nav>
		<ul>
			<li if={ !login } class={ active: activeId == 'entrance' }><a href='/'>Entrance</a></li>
			<li if={ login } class={ active: activeId == 'home' }><a href='/'>Home</a></li>
			<li class={ active: activeId == 'dev' }><a href='/dev'>DevCenter</a></li>
			<virtual if={ userId != null }>
				<li class={ active: activeId == 'userlist'}><a href='/userlist'>UserList</a></li>
				<li style='margin-left: auto'><a href={ '/users/' + user.screenName }>@{ user.screenName }</a></li>
				<li><frost-logout-button /></li>
			</virtual>
		</ul>
	</nav>

	<style>
		@import "../styles/variables";

		:scope {
			position: fixed;
			width: 100%;
			background-color: hsla(216, 100%, 98%, 0.85);
			box-shadow: 0px 0px 6px 0px hsla(0, 0%, 0%, 0.5);
			overflow: hidden;

			ul {
				@include responsive(row);

				flex-direction: row;
				list-style-type: none;
				align-items: center;
				height: 45px;

				@media (max-width: $tablet - 1px) {
					overflow-x: auto;
					overflow-y: hidden;
				}

				> li {
					margin: 0;
					height: 100%;
					min-width: 75px;
					width: 100px;

					a {
						height: 100%;
						display: flex;
						align-items: center;
						border-bottom: 3px solid hsla(0, 0%, 0%, 0);
						justify-content: center;
						text-decoration-line: none;
						color: hsla(0, 0%, 0%, 0.7);
						padding-top: 3px;
					}
				}

				> li.active {
					a {
						border-bottom-color: hsl(194, 76%, 49%);
						color: hsl(194, 76%, 49%);
					}
				}
			}
		}
	</style>

	<script>
		const changedLoginStatusEventHandler = login => {
			this.login = login;
			this.update();
		};

		const changePageHandler = pageId => {
			this.activeId = pageId;
			this.update();
		};

		this.on('mount', () => {
			this.central.on('ev:changed-login-status', changedLoginStatusEventHandler);
			this.central.on('change-page', changePageHandler);

			this.login = this.getLogin();
		});

		this.on('unmount', () => {
			this.central.off('ev:changed-login-status', changedLoginStatusEventHandler);
			this.central.off('change-page', changePageHandler);
		});
	</script>
</frost-header>
