# Modular R Shiny App Structure

This folder contains the refactored, modular version of the R Shiny app for non-parametric statistical tests.

## Directory Structure

```
app/
├── app.R                           # Main application entry point
├── modules/                        # Shiny modules
│   ├── input_panel_module.R       # Input panel module (UI + Server)
│   └── results_panel_module.R     # Results panel module (UI + Server)
└── utils/                         # Utility functions
    ├── stat_tests.R               # Statistical test functions
    ├── csv_utils.R                # CSV file handling utilities
    ├── emission_utils.R           # Emission data processing utilities
    ├── notification_helpers.R     # Notification and message utilities
    ├── plot_utils.R               # Plot generation utilities
    └── ui_helpers.R               # UI component creation utilities
```

## Key Improvements

### 1. Modularization
- **Statistical Tests**: All test functions moved to `utils/stat_tests.R`
- **Data Import**: File processing moved to `utils/csv_utils.R` (now supports CSV, Excel, and SPSS formats)
- **Emission Data Processing**: Emission-related utilities in `utils/emission_utils.R`
- **Notifications**: Consistent notification system in `utils/notification_helpers.R`
- **Plotting**: All plotting logic moved to `utils/plot_utils.R`
- **UI Helpers**: Reusable UI components in `utils/ui_helpers.R`

### 2. Shiny Modules
- **Input Panel Module**: Handles all input-related UI and server logic
- **Results Panel Module**: Manages results display and visualization
- **Module Communication**: Uses reactive values to pass data between modules

### 3. Code Quality
- **Consistent Naming**: Standardized variable and function names
- **Documentation**: Added Roxygen-style documentation
- **Error Handling**: Improved error handling and user feedback
- **Lint Compliance**: Fixed linting issues where applicable

## Recent Updates

### Emission Data Analysis UI/UX Improvements
- **No Default Selection**: Country and year dropdowns now require explicit user selection with proper placeholders
- **Descending Year Order**: Years are now shown in descending order (2023→1970) for easier selection of recent years
- **Fixed Algeria Bug**: Country selection now works correctly across all emission datasets (CH4, CO2, N2O, TOTAL)
- **Valid Year Selection**: Year dropdowns now only show years that have actual data (1970-2023)
- **Enhanced Dropdowns**: Implemented Selectize.js placeholders for all dropdowns to clearly indicate selection requirement

For a complete list of fixed issues and improvements, see [FEATURE_ANALYSIS.md](FEATURE_ANALYSIS.md).

## How to Run

1. Set your working directory to the `app/` folder
2. Run: `shiny::runApp("app.R")`

Or from the parent directory:
```r
shiny::runApp("app/")
```

## Key Functions

### Statistical Tests (`utils/stat_tests.R`)
- `perform_sign_test()` - Sign test implementation
- `perform_wilcoxon_test()` - Wilcoxon signed-rank test
- `perform_run_test()` - Run test for randomness
- `perform_mannwhitney_test()` - Mann-Whitney U test

### CSV Utilities (`utils/csv_utils.R`)
- `read_csv_robust()` - Robust CSV file reading
- `parse_manual_samples()` - Parse manual input samples
- `generate_csv_template()` - Generate CSV template

### Emission Utilities (`utils/emission_utils.R`)
- `process_emission_data()` - Process and clean emission data
- `aggregate_emission_data()` - Aggregate emission data by country and year
- `filter_emission_data()` - Filter emission data based on user input

### Plot Utilities (`utils/plot_utils.R`)
- `create_main_plot()` - Create main visualization
- `create_difference_plot()` - Create difference plots
- `render_test_summary()` - Render test results summary
- `plot_emission_trends()` - Plot emission trends over time

### UI Helpers (`utils/ui_helpers.R`)
- `create_info_box()` - Create styled info boxes
- `create_test_selection()` - Create test selection UI
- `create_file_upload_section()` - Create file upload UI
- `create_manual_input_section()` - Create manual input UI
- `create_emission_ui()` - Create UI components for emission data analysis

### Notification Helpers (`utils/notification_helpers.R`)
- `show_success_notification()` - Show success message
- `show_error_notification()` - Show error message
- `show_warning_notification()` - Show warning message

## Module Structure

### Input Panel Module
- **UI Function**: `input_panel_ui(id)`
- **Server Function**: `input_panel_server(id, parent_session)`
- **Responsibilities**: Data input, validation, file handling

### Results Panel Module
- **UI Function**: `results_panel_ui(id)`
- **Server Function**: `results_panel_server(id, input_data, test_type, alpha, run_trigger)`
- **Responsibilities**: Test execution, results display, visualization

## Benefits of Modular Structure

1. **Maintainability**: Easier to find and modify specific functionality
2. **Reusability**: Functions and modules can be reused across projects
3. **Testing**: Individual components can be tested separately
4. **Collaboration**: Multiple developers can work on different modules
5. **Scalability**: Easy to add new features or statistical tests
6. **Code Quality**: Better organization leads to cleaner, more readable code

## Migration from Original

The original `app.R` file has been completely refactored. All functionality is preserved, but the code is now organized into logical modules and utility functions. The app behavior remains identical to the original version.

## Future Enhancements

With this modular structure, you can easily:
- Add new statistical tests by extending `utils/stat_tests.R`
- Add new visualization types in `utils/plot_utils.R`
- Create additional UI modules for new features
- Implement unit tests for individual components
- Add new data import formats in `utils/csv_utils.R`
