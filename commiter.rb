require 'date'
require 'fileutils'

# Function to generate a random date within the last year
def random_date
    start_date = DateTime.now - 365
    end_date = DateTime.now
    random_days = rand((end_date - start_date).to_i)
    start_date + random_days
end

# Function to create a commit with a random date
def create_commit(file_path, commit_message)
    date = random_date.iso8601
    File.open(file_path, 'a') { |file| file.puts "Commit on #{date}" }
    system("git add #{file_path}")
    system("GIT_AUTHOR_DATE='#{date}' GIT_COMMITTER_DATE='#{date}' git commit -m '#{commit_message}'")
end

# Main script
file_path = 'random_commits.txt'
commit_message = 'Random commit'

# Initialize git repository if not already initialized
unless Dir.exist?('.git')
    system('git init')
end

# Create 10 random commits
10.times do
    create_commit(file_path, commit_message)
end