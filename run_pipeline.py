from mage_ai.data_preparation.models.pipeline import Pipeline
import asyncio

async def run_pipeline():
    # Initialize pipeline
    pipeline = Pipeline(
        'weekly_streamer_stats',
        repo_path='.'
    )
    
    # Execute pipeline
    await pipeline.execute()

if __name__ == "__main__":
    # Run the async function
    asyncio.run(run_pipeline())