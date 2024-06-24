process_batch() {
  files=$1
  batch_num=$2

  # Stage the files
  git add $files

  # Commit the files
  git commit -m "Batch $batch_num of images"

  # Push the files
  git push origin main
}

# Split files into batches of 5000
batch_size=5000
counter=0
batch_num=1
for file in images/*; do
  counter=$((counter + 1))

  # Add the file to the staging area
  git add "$file"

  # Check if the batch is complete
  if [ $((counter % batch_size)) -eq 0 ]; then
    process_batch "images/*" $batch_num
    batch_num=$((batch_num + 1))
  fi
done

# Process the remaining files if any
if [ $((counter % batch_size)) -ne 0 ]; then
  process_batch "images/*" $batch_num
fi