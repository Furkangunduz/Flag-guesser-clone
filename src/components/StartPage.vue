<template>
	<div class="start-page">
		<button class="basla-btn" @click="startGame(userName)">Basla</button>
		<input v-model="userName" maxlength="8" class="input-name" type="text" placeholder="name" />
	</div>
</template>
<script>
	export default {
		data() {
			return { userName: '' };
		},
		inject: ['startGame'],
	};
</script>
