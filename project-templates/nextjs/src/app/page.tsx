export default function Home() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100">
      <main className="text-center p-8">
        <h1 className="text-5xl font-bold text-gray-900 mb-4">
          Welcome to My App
        </h1>
        <p className="text-xl text-gray-600 mb-8">
          Your Next.js application is up and running!
        </p>
        <div className="flex gap-4 justify-center">
          <a
            href="https://nextjs.org/docs"
            target="_blank"
            rel="noopener noreferrer"
            className="px-6 py-3 bg-black text-white rounded-lg hover:bg-gray-800 transition-colors"
          >
            Read Docs
          </a>
          <a
            href="https://github.com"
            target="_blank"
            rel="noopener noreferrer"
            className="px-6 py-3 border-2 border-black text-black rounded-lg hover:bg-black hover:text-white transition-colors"
          >
            View on GitHub
          </a>
        </div>
        <div className="mt-12 p-6 bg-white rounded-lg shadow-lg max-w-md mx-auto">
          <h2 className="text-2xl font-semibold mb-3">Getting Started</h2>
          <p className="text-gray-600 text-left">
            Edit <code className="bg-gray-100 px-2 py-1 rounded">src/app/page.tsx</code> to customize this page.
          </p>
        </div>
      </main>
    </div>
  );
}

