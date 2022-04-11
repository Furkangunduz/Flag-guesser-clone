<!-- @format -->

<template>
	<div class="finishCard">
		<h2>Congratulations ! {{ userName.userName }}</h2>
		<h2>
			Your score is
			<span style="color: red">{{ score.score }} / {{ countriesLen }}</span>
		</h2>
		//\\
		<button @click="$emit('restart')">Play Again</button>
	</div>
</template>
<script>
	export default {
		inject: ['score', 'userName', 'countriesLen'],
	};
</script>
<style scoped>
	.finishCard {
		display: flex;
		flex-direction: column;
		align-items: center;
		background-color: rgba(56, 56, 56, 0.97);
		padding: 50px 25px;
		width: 30%;
		text-align: center;
		color: white;
		border-radius: 20px;
	}
</style>
