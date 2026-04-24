# NELC Songbook - Designer Handoff Document

## 1. Application Overview
**What it is:** A digital hymnal and song collection application designed for mobile devices.
**What it does:** It provides users with instantaneous, offline access to a large library of local hymnals. Users can browse a comprehensive index, search for specific songs by their assigned hymnal number or lyrical contents, clearly read the lyrics, and curate a personal list of favorite songs.

## 2. Core Data Structures
The entire application centers around a single core entity: the **Song**.

### Song Data Model
- **Number / ID** (`Integer`): The canonical assigned song number (identifying it within the physical hymnal).
- **Title** (`String`): The full name of the song.
- **Categorical Character** (`String`): The first letter or phonetic grouping used for A-Z categorical browsing.
- **Lyrics** (`Rich Text / HTML`): The full textual lyrics. This is primarily multi-line text, often containing stanzas or basic HTML tag formatting for line breaks.
- **Favorite Status** (`Boolean`): A persistent local toggle specifying if the user has saved the song.

## 3. Core Features
- **A-Z Library Filtering:** Quick library browsing by selecting alphabetical tabs, chips, or sections.
- **Deep Smart Search:** A global search mechanism allowing users to type a numeric digit (direct ID lookup) or natural text words (matches against song titles).
- **Personalization:** Saving songs to a local "Favorites" roster for fast access during live events or services.
- **Offline First:** The database is entirely local.

## 4. User Journey & Application Flow

### Screen 1: Songbook Selection (Entry Point)
- The initial launch screen where users select which specific hymnal or book collection they want to open.
- **Flow:** User selects a book -> transitions to the Home Page.

### Screen 2: Home Page (Main Library)
- The primary dashboard of the application.
- **Elements Needed:**
  - A comprehensive scrolling list displaying Song Cards (typically showing Title and Number).
  - Alphabetical filters (e.g., A, B, C... All) allowing users to jump between sections of the massive library.
  - A Global Search entry point (e.g., a search icon or a persistent expanding bar).
  - The **Bottom Navigation Bar** (Controls navigation between "Home" and "Favorites").

### Screen 3: Search View
- Triggered from the Home Page. It acts as a dedicated sub-page or focused overlay.
- **Elements Needed:**
  - An active text input field.
  - A dynamic scrolling list of matching result cards that update instantly as the user types.

### Screen 4: Song Detail Page
- Reached by tapping any individual song card from the Home, Favorites, or Search screens.
- **Elements Needed:**
  - Highly focused on typography and comfortable reading.
  - Displays the Song Title, the Song Number, and the full multi-line formatted lyrics.
  - A prominent "Favorite/Unfavorite" floating action or icon toggle.
  - A clear "Back" navigation control to return to the previous list.

### Screen 5: Favorites Page
- Reached via the Bottom Navigation Bar.
- **Elements Needed:**
  - Functionally identical in structure to the Home Page list, but exclusively displays songs the user has toggled as a favorite.
  - Clear empty-states (e.g. "You haven't favored any songs yet") if the list is empty. 
