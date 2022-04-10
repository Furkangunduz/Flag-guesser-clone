<template>
	<div class="card">
		<h2>Congratulations ! {{ userName }}</h2>
		<h2>
			Your score <span style="color: red">{{ score.score }}</span>
		</h2>
		//\\
		<button @click="$emit('restart')">Play Again</button>
	</div>
</template>
<script>
	export default {
		inject: ['score', 'userName'],
	};
</script>
<style scoped>
	.card {
		display: flex;
		flex-direction: column;
		background-color: rgba(56, 56, 56, 0.97);
		padding: 50px 25px;
		width: 30%;
		text-align: center;
		color: white;
		border-radius: 20px;
	}
</style>
