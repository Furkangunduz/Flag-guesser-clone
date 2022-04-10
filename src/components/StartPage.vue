<template>
	<div class="start-page">
		<!-- <input v-model="userName" maxlength="8" class="input-name" type="text" placeholder="name" /> -->
		<button class="basla-btn" @click="startGame(userName)">Basla</button>
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
